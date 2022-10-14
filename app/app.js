const args = process.argv.slice(2)
if (args == []){
    console.log("Welcome to dtsman\nStart automatically creating your .d.ts file by doing\n node dtsman C:\\exampleProject\\objects.d.ts 8080\nthe first argument: path of .d.ts file to write, second is simply the localhost port you want.")
}