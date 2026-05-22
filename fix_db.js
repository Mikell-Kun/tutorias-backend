import db from './src/config/db.js';

async function run() {
    try {
        console.log("Fixing DB departments...");
        await db.query("UPDATE usuarios SET departamento = 'Sistemas Computacionales' WHERE departamento = 'Sistemas' AND rol = 'docente'");
        await db.query("UPDATE usuarios SET carrera = 'Ingeniería en Sistemas Computacionales' WHERE carrera = 'Sistemas' AND rol = 'estudiante'");
        console.log("Database updated successfully!");
    } catch(e) {
        console.error(e);
    } finally {
        process.exit(0);
    }
}
run();
