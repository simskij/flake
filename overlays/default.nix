{
  inputs,
  ...
}: {
  additions = _final: _prev: { };
  modifications = _final: _prev: { };

  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}
