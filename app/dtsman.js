const fs = require("fs")
const args = process.argv.slice(2)
if (args.length < 1){
    console.log("Welcome to dtsman\nStart automatically creating your .d.ts file by doing (example)\nnode dtsman C:\\exampleProject\\objects.d.ts 8080\nthe first argument: path of .d.ts file to write, second is simply the localhost port you want.")
} else {
    const path = args[0]
    const httpPort = args[1]
    const express = require("express")
    const app = express()
    const bodyparser = require("body-parser")
    app.use(bodyparser.json())
    app.get("/", (req, res) => {
        res.send("dtsman")
    })
    app.post("/dts/", (req, res) => {
        const toWrite = req.body
        console.log(toWrite)
        fs.writeFileSync(path, JSON.stringify(toWrite))
    })
    app.listen(httpPort, () => {
        console.log("Ready! connect your plugin now\nWrite in the port you just typed here in the plugin\nYou can kill this task by doing ctrl + c")
    })
}