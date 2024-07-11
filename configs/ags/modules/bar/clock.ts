const time = Variable("", {
    poll: [100, 'date "+%H:%M:%S"'],
})

export function Clock() {
    return Widget.Label({
        class_names: ["clock", "module-lvl1"],
        label: time.bind(),
        justification: "center",
    })
}
export { }
