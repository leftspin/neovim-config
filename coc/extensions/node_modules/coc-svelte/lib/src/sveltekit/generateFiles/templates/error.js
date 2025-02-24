"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
async function default_1(config) {
    const ts = `
<script lang="ts">
    import { page } from '$app/stores';
</script>

<h1>{$page.status}: {$page.error?.message}</h1>
    `.trim();
    const js = `
<script>
    import { page } from '$app/stores';
</script>

<h1>{$page.status}: {$page.error.message}</h1>
    `.trim();
    return config.type === 'js' ? js : ts;
}
exports.default = default_1;
//# sourceMappingURL=error.js.map