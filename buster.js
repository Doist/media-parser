var config = module.exports;

config["i18n tests"] = {
    environment: "node",
    extensions: [require("buster-coffee")],
    tests: [
        "tests/test_*.coffee"
    ]
};
