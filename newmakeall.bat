@echo off
echo REBUILDING AROMA INSTALLER
echo ==========================
echo.
echo * Creating directories
mkdir obj
mkdir out
cd obj
echo * Cleanup objects
del /F /Q /S *.*
echo.
echo * Compiling... This may take a moments...
echo.

REM F:\cygwin64\home\Administrator\gcc-arm-8.3-2019.03-i686-mingw32-arm-eabi\bin\arm-eabi-gcc-8.3.0 ^
F:\cygwin64\home\Administrator\gcc-linaro-6.5.0-2018.12-rc1-i686-mingw32_arm-linux-gnueabi\bin\arm-linux-gnueabi-gcc.exe ^
  -save-temps ^
  -O2 -static -fdata-sections ^
  -ffunction-sections ^
  -Wl,--gc-sections ^
  -fPIC -DPIC ^
  -Wl,-s -Werror ^
  -D_GLIBCXX_DEBUG_PEDANTIC ^
  -D_GLIBCXX_DEBUG ^
  -D_AROMA_NODEBUG ^
  -DFT2_BUILD_LIBRARY=1 ^
  -DDARWIN_NO_CARBON ^
  -mfloat-abi=softfp -mfpu=neon ^
  -D__ARM_HAVE_NEON ^
    ^
      ../libs/zlib/adler32.c ^
      ../libs/zlib/crc32.c ^
      ../libs/zlib/infback.c ^
      ../libs/zlib/inffast.c ^
      ../libs/zlib/inflate.c ^
      ../libs/zlib/inftrees.c ^
      ../libs/zlib/zutil.c ^
      ../libs/zlib/inflate_fast_copy_neon.s ^
      ^
      ../libs/png/png.c ^
      ../libs/png/pngerror.c ^
      ../libs/png/pnggccrd.c ^
      ../libs/png/pngget.c ^
      ../libs/png/pngmem.c ^
      ../libs/png/pngpread.c ^
      ../libs/png/pngread.c ^
      ../libs/png/pngrio.c ^
      ../libs/png/pngrtran.c ^
      ../libs/png/pngrutil.c ^
      ../libs/png/pngset.c ^
      ../libs/png/pngtrans.c ^
      ../libs/png/pngvcrd.c ^
      ../libs/png/png_read_filter_row_neon.s ^
      ^
      ../libs/minutf8/minutf8.c ^
      ../libs/minzip/DirUtil.c ^
      ../libs/minzip/Hash.c ^
      ../libs/minzip/Inlines.c ^
      ../libs/minzip/SysUtil.c ^
      ../libs/minzip/Zip.c ^
      ^
      ../libs/freetype/autofit/autofit.c ^
      ../libs/freetype/base/basepic.c ^
      ../libs/freetype/base/ftapi.c ^
      ../libs/freetype/base/ftbase.c ^
      ../libs/freetype/base/ftbbox.c ^
      ../libs/freetype/base/ftbitmap.c ^
      ../libs/freetype/base/ftglyph.c ^
      ../libs/freetype/base/ftinit.c ^
      ../libs/freetype/base/ftpic.c ^
      ../libs/freetype/base/ftstroke.c ^
      ../libs/freetype/base/ftsynth.c ^
      ../libs/freetype/base/ftsystem.c ^
      ../libs/freetype/cff/cff.c ^
      ../libs/freetype/pshinter/pshinter.c ^
      ../libs/freetype/psnames/psnames.c ^
      ../libs/freetype/raster/raster.c ^
      ../libs/freetype/sfnt/sfnt.c ^
      ../libs/freetype/smooth/smooth.c ^
      ../libs/freetype/truetype/truetype.c ^
      ../libs/freetype/base/ftlcdfil.c ^
      ^
      ../src/edify/expr.c ^
      ../src/edify/lex.yy.c ^
      ../src/edify/parser.c ^
      ../src/libs/aroma_array.c ^
      ../src/libs/aroma_freetype.c ^
      ../src/libs/aroma_graph.c ^
      ../src/libs/aroma_input.c ^
      ../src/libs/aroma_languages.c ^
      ../src/libs/aroma_libs.c ^
      ../src/libs/aroma_memory.c ^
      ../src/libs/aroma_png.c ^
      ../src/libs/aroma_zip.c ^
      ../src/controls/aroma_controls.c ^
      ../src/controls/aroma_control_button.c ^
      ../src/controls/aroma_control_check.c ^
      ../src/controls/aroma_control_checkbox.c ^
      ../src/controls/aroma_control_checkopt.c ^
      ../src/controls/aroma_control_imgbutton.c ^
      ../src/controls/aroma_control_menubox.c ^
      ../src/controls/aroma_control_optbox.c ^
      ../src/controls/aroma_control_textbox.c ^
      ../src/main/aroma.c ^
      ../src/main/aroma_installer.c ^
      ../src/main/aroma_ui.c ^
  	^
  -I../include ^
  -I../src ^
  -o ../out/aroma_installer ^
  -lm -lpthread

echo.
echo * Cleanup AROMA Installer objects
echo.
del aroma*

echo.
cd ..

echo * Copying binary into release
echo.
copy out\aroma_installer assets\META-INF\com\google\android\update-binary
echo.

echo Press Enter to Build Release ZIP
pause
echo * Creating Release Zip
cd assets
..\tools\7z a -mx9 -tzip ..\out/aroma.zip .
cd ..

echo.

echo =============================
echo CTRL-C = Exit, Enter = Deploy
echo.
pause
echo.
deploy.bat