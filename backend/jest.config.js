module.exports = {
  "transform": {
    "^.+\\.(ts|js|html)$": "ts-jest"
}
  "testRegex": "(/__tests__/.*|(\\.|/)(test|spec))\\.(jsx?|tsx?)$",
  "moduleFileExtensions": [
    "ts",
    "tsx",
    "js",
    "jsx",
    "json",
    "node"
  ],
  "setupFiles": [
    "<rootDir>/test/setupTests.ts"
  ]
};
