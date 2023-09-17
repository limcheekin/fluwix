import init, {
  Universe,
  Cell,
  get_memory_buffer,
} from "./wasm_game_of_life.js";

// REF: https://stackoverflow.com/questions/52276662/using-dart-js-interop-with-es6-classes
window.Universe = Universe;
window.Cell = Cell;
window.get_memory_buffer = get_memory_buffer;

// Init the Wasm module
await init();

console.log("index.js loaded!!!");
