"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
async function default_1(config) {
    const ts = `
import type { PageServerLoad } from './$types';

export const load: PageServerLoad = async () => {
    return {};
};
    `.trim();
    const tsSatisfies = `
import type { PageServerLoad } from './$types';

export const load = (async () => {
    return {};
}) satisfies PageServerLoad;
    `.trim();
    const js = `
/** @type {import('./$types').PageServerLoad} */
export async function load() {
    return {};
};
    `.trim();
    return config.type === 'js' ? js : config.type === 'ts' ? ts : tsSatisfies;
}
exports.default = default_1;
//# sourceMappingURL=page-server.js.map