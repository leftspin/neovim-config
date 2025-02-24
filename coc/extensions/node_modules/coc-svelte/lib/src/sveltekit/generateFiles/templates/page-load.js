"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
async function default_1(config) {
    const ts = `
import type { PageLoad } from './$types';

export const load: PageLoad = async () => {
    return {};
};
    `.trim();
    const tsSatisfies = `
import type { PageLoad } from './$types';

export const load = (async () => {
    return {};
}) satisfies PageLoad;
    `.trim();
    const js = `
/** @type {import('./$types').PageLoad} */
export async function load() {
    return {};
};
    `.trim();
    return config.type === 'js' ? js : config.type === 'ts' ? ts : tsSatisfies;
}
exports.default = default_1;
//# sourceMappingURL=page-load.js.map