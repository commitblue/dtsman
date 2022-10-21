const fs = require("fs")
let args = process.argv
const lastIndex = __filename.lastIndexOf(".")
if (__filename.substring(lastIndex, __filename.length) == "exe"){
    args = args.slice(1)
} else {
    args = args.slice(2)
}
if (args.length < 1){
    console.log("Welcome to dtsman\nStart automatically creating your .d.ts file by doing (example)\nnode dtsman C:\\exampleProject\\objects.d.ts 8080\nthe first argument: path of .d.ts file to write, second is simply the localhost port you want.")
} else {
    const path = args[0]
    const httpPort = args[1]
    const express = require("express")
    const app = express()
    app.get("/", (req, res) => {
        res.send("dtsman")
    })
    app.use(express.json())
    app.post("/dts/", require("body-parser").urlencoded({extended:true}), (req, res) => {
        const toWrite = req.body.text
        fs.writeFileSync(path, toWrite)
        res.status(200).send("OK")
    })
    app.listen(httpPort, () => {
        console.log("Ready! connect your plugin now\nWrite in the port you just typed here in the plugin\nYou can kill this task by doing ctrl + c\nhttps://localhost:" + httpPort + "/")
    })
}