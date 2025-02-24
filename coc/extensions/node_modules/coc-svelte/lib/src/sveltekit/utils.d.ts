export declare function fileExists(file: string): Promise<boolean>;
export declare function findFile(searchPath: string, fileName: string): Promise<string | undefined>;
export declare function checkProjectType(path: string): Promise<"js" | "ts" | "ts-satisfies">;
