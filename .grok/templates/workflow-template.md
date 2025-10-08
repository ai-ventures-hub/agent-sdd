# sdd-task --{{workflow_name}} {{arguments}}

PURPOSE: {{workflow_purpose}}

{{#if supported_types}}
SUPPORTED_TYPES: {{supported_types}}
{{/if}}

WORKFLOW_STEPS:

SEQUENCE_GUARDS:
- PRE_FLIGHT:
  - REQUIRE dispatcher pre-flight validations completed
  - IF not → RETURN {{errors.shared.ERR_014}}
- AGENT_GATES:
  {{#each required_agents}}
  - REQUIRE {{this}} invoked {{timing}}
  {{/each}}
  - IF missing → RETURN {{errors.shared.ERR_011}}
- ORDER_ENFORCEMENT:
  - IF steps executed out of order → RETURN {{errors.shared.ERR_012}}

{{#if pre_steps}}
0. PRE_EXECUTION:
{{#each pre_steps}}
   - {{this}}
{{/each}}
{{/if}}

1. PARSE_ARGUMENTS:
   {{#each arguments}}
   - {{name}}: {{required_optional}} {{description}}
   {{/each}}
   - IF missing required arguments → RETURN {{errors.shared.ERR_002}}

2. CONTEXT_GATHERING:
   - {{agents.context_manager}} → collect relevant context
   {{#each context_requirements}}
   - {{this}}
   {{/each}}

{{#each workflow_steps}}
{{step_number}}. {{step_name}}:
   {{#each actions}}
   - {{this}}
   {{/each}}
   {{#if validation}}
   - VALIDATE: {{validation}}
   {{/if}}
   {{#if error_condition}}
   - IF {{error_condition}} → RETURN {{error_code}}
   {{/if}}

{{/each}}

{{#if validation_levels}}
VALIDATION_LEVELS:
{{#each validation_levels}}
- {{type}}: {{level}} ({{checks}})
{{/each}}
{{/if}}

AGENT_INVOCATIONS:
{{#each agent_invocations}}
- {{agents.{{agent_name}}}} - {{description}}
{{/each}}

ERROR_HANDLING:
{{#each error_handlers}}
- {{error_name}} {{error_code}}: {{error_description}}
{{/each}}

{{#if fallback_strategies}}
FALLBACK_STRATEGIES:
{{#each fallback_strategies}}
- {{condition}} → {{action}}
{{/each}}
{{/if}}