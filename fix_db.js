import db from './src/config/db.js';

async function run() {
    try {
        console.log("Fixing DB departments...");
        await db.query("UPDATE docentes SET departamento = 'Sistemas Computacionales' WHERE departamento = 'Sistemas'");
        await db.query("UPDATE estudiantes SET carrera = 'Ingeniería en Sistemas Computacionales' WHERE carrera = 'Sistemas'");
        console.log("Database updated successfully!");
    } catch(e) {
        console.error(e);
    } finally {
        process.exit(0);
    }
}
run();
