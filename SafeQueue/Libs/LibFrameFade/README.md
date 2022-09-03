# LibFrameFade

LibFrameFade is a World of Warcraft library that attempts to resolve UIFrameFade taint by reimplementing it to use the UI widget animation framework. This can help resolve issues such as "Interface action blocked by an addon" errors when attempting to perform actions such as joining battlegrounds or arenas in Classic Era or Burning Crusade Classic.

The design of the library is similar to [LibChatAnims](https://www.curseforge.com/wow/addons/libchatanims). You can either install it as a standalone addon, or embed it within another, and it will automatically manage UIFrameFade animations **without any code changes required**.

## Embedding

The library may be imported as an external in a `.pkgmeta` file as shown below, through the use of a Git submodule, or by downloading an existing packaged release and copying it into your addon folder.

```yaml
externals:
  Libs/LibFrameFade: https://github.com/Meorawr/LibFrameFade
```

To load the library include a reference to the `lib.xml` file either within your TOC or through an XML Include element.

```xml
<Ui xmlns="http://www.blizzard.com/wow/ui/">
    <Include file="Libs\LibFrameFade\lib.xml"/>
</Ui>
```

## License

The library is released under the terms of the [Unlicense](https://unlicense.org/), a copy of which can be found in the `LICENSE` document at the root of the repository.

## Contributors

* [Daniel "Meorawr" Yates](https://github.com/meorawr)
