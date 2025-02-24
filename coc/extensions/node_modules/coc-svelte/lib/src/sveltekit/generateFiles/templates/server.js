"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
async function generate(config) {
    const ts = `
import type { RequestHandler } from './$types';

export const GET: RequestHandler = async () => {
    return new Response();
};
    `.trim();
    const js = `
/** @type {import('./$types').RequestHandler} */
export async function GET() {
    return new Response();
};
    `.trim();
    return config.type === 'js' ? js : ts;
}
exports.default = generate;
//# sourceMappingURL=server.js.map