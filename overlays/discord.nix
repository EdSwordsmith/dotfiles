{ ... }:

final: prev: {
  discord = prev.unstable.discord.override { withOpenASAR = true; };
}
