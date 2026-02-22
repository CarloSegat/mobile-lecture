Agent Skills

Agent Skills allow you to extend Gemini CLI with specialized expertise, procedural workflows, and task-specific resources. Based on the Agent Skills open standard, a “skill” is a self-contained directory that packages instructions and assets into a discoverable capability.
Overview
Unlike general context files (GEMINI.md), which provide persistent workspace-wide background, Skills represent on-demand expertise. This allows Gemini to maintain a vast library of specialized capabilities—such as security auditing, cloud deployments, or codebase migrations—without cluttering the model’s immediate context window.
Gemini autonomously decides when to employ a skill based on your request and the skill’s description. When a relevant skill is identified, the model “pulls in” the full instructions and resources required to complete the task using the activate_skill tool.
Key Benefits
Shared Expertise: Package complex workflows (like a specific team’s PR review process) into a folder that anyone can use.
Repeatable Workflows: Ensure complex multi-step tasks are performed consistently by providing a procedural framework.
Resource Bundling: Include scripts, templates, or example data alongside instructions so the agent has everything it needs.
Progressive Disclosure: Only skill metadata (name and description) is loaded initially. Detailed instructions and resources are only disclosed when the model explicitly activates the skill, saving context tokens.