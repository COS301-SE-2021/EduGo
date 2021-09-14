const getKey = (key: string) => key.substring(key.lastIndexOf('/') + 1);
const generateOutputName = (input: string) => `${input.replace(".glb", ".gltf")}`;
const removeExtension = (input: string) => input.replace(".glb", "");
export const getGltfLink = (input: string) => `${removeExtension(input)}/${generateOutputName(getKey(input))}`;