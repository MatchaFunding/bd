class Propuesta {
    ID: number;
    Idea: number;
    Resumen: string;
    constructor(json: any) {
        this.ID = json.ID;
        this.Usuario = json.Usuario;
        this.ResumenLLM = json.ResumenLLM;
    }
}
export default Propuesta;
