import libc;
import std::io;
import std::os;

fn void main() {

  PathList? paths = io::path::ls(tmem, "../shaders/".to_tpath()!!, true);

  if (catch err = paths) {
    io::eprintfn("Faild to find shaders: %s", err);
    os::exit(-1);
  }

  foreach (file : paths) {
    @pool() {

      String? ext = file.extension();
      if (catch err = ext) continue;
      if (ext != "glsl") continue;

      String basename = file.basename();
      usz? index = basename.rindex_of(".");
      if (catch err = index) continue;

      String filename = basename[..index - 1];

      String input_path = string::tformat("../shaders/%s", file);
      String output_path = string::tformat("../src/shaders/%s.c3", filename);

      SubProcess? process = process::create({
        "../tools/sokol-shdc.exe",
        "--input", input_path,
        "--output", output_path,
        "--format", "sokol_c3",
        "--slang", "glsl430:hlsl5:metal_macos",
      }, {
        .inherit_stdio = true,
      });

      if (catch err = process) {
        io::eprintfn("Shader compiler exited with errror: %s", err);
        os::exit(-1);
      }

      CInt? exit_code = process.join();

      if (catch err = exit_code) {
        io::eprintfn("Shader compiler exited with errror: %s", err);
        os::exit(-1);
      }

      if (exit_code != 0) {
        io::eprintfn("Shader compiler exited with errror: %s", exit_code);
        os::exit(-1);
      }
    };
  }
}