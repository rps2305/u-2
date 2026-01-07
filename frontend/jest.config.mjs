import { resolve } from 'path';
import { fileURLToPath } from 'url';

const __dirname = fileURLToPath(new URL('.', import.meta.url));

export default {
  testMatch: ['**/*.test.js'],
  testEnvironment: 'jsdom',
  setupFilesAfterEnv: [resolve(__dirname, 'jest.setup.js')],
  collectCoverageFrom: [
    resolve(__dirname, 'src/js/**/*.js'),
  ],
  coverageDirectory: resolve(__dirname, 'coverage'),
  coverageReporters: ['text', 'lcov', 'html'],
  coverageThreshold: {
    global: {
      branches: 80,
      functions: 80,
      lines: 80,
      statements: 80
    }
  }
};