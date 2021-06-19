module.exports = {
<<<<<<< HEAD
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
=======
  preset: 'ts-jest',
  testEnvironment: 'node',
};
>>>>>>> parent of 71e8483 (Update jest.config.js)
