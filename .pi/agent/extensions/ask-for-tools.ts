/**
 * Ask For Tools Extension
 *
 * Asks for confirmation before any tool call runs, by default.
 *
 * - On every tool_call, prompts with a short confirm: "Allow <tool>?"
 * - "Yes (always this session)" remembers the choice for that tool name.
 * - In non-interactive mode (no UI), tool calls are blocked by default.
 *
 * Edit `allowAlways` below to whitelist tools that never prompt.
 * Reload with /reload after editing.
 *
 * Place at ~/.pi/agent/extensions/ask-for-tools.ts (auto-discovered, hot-reloadable).
 */

import {
  isToolCallEventType,
  type ExtensionAPI,
  type ToolCallEvent,
} from "@earendil-works/pi-coding-agent";
import { resolve, relative } from "node:path";
import { readFile } from "node:fs/promises";

// Tools that never require a prompt. Edit freely.
const allow_always = new Set<string>(["read"]);

// Returns true if `target` resolves outside `cwd`.
function is_outside_cwd(target: string, cwd: string): boolean {
  return relative(cwd, resolve(cwd, target)).startsWith("..");
}

// Returns true if the tool is auto-allowed without a prompt.
function is_auto_allowed(event: ToolCallEvent, cwd: string): boolean {
  if (!allow_always.has(event.toolName)) return false;
  if (isToolCallEventType("read", event))
    return !is_outside_cwd(event.input.path, cwd);
  return true;
}

// Returns true if the call is doomed to fail, so we skip prompting and let it
// error on its own instead of asking the user for permission.
async function will_fail(event: ToolCallEvent): Promise<boolean> {
  if (isToolCallEventType("edit", event)) {
    try {
      const content = await readFile(event.input.path, "utf8");
      return event.input.edits.some((e) => !content.includes(e.oldText));
    } catch {
      return true; // unreadable / missing file
    }
  } else {
    return false;
  }
}

export default function (pi: ExtensionAPI) {
  // Tools the user has approved for the rest of this session.
  const allow_this_session = new Set<string>();

  pi.on("session_start", () => {
    // Reset session-scoped approvals on every (re)start.
    allow_this_session.clear();
  });

  pi.on("tool_call", async (event, ctx) => {
    if (
      is_auto_allowed(event, ctx.cwd) ||
      allow_this_session.has(event.toolName) ||
      (await will_fail(event))
    ) {
      return undefined; // allow (auto-allowed, pre-approved, or doomed anyway)
    }

    if (!ctx.hasUI) {
      return {
        block: true,
        reason: `Tool "${event.toolName}" blocked: confirmation not available in non-interactive mode.`,
      };
    }

    const choice = await ctx.ui.select(`Allow "${event.toolName}"?`, [
      "Yes",
      `Always allow "${event.toolName}" this session`,
      "No",
    ]);

    if (choice === "Yes") {
      return undefined; // allow this once
    }

    if (choice === `Always allow "${event.toolName}" this session`) {
      allow_this_session.add(event.toolName);
      return undefined; // allow now and for the rest of the session
    }

    return {
      block: true,
      reason: `Blocked by user (${event.toolName}).`,
    };
  });
}
