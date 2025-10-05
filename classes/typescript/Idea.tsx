class Idea {
    ID: number;
    Usuario: number;
    Campo: string;
    Problema: string;
    Publico: string;
    Innovacion: string;
    FechaDeCreacion?: string;
    UltimaFechaDeModificacion?: string;
    constructor(json: any) {
        this.ID = json.ID;
        this.Usuario = json.Usuario;
        this.Campo = json.Campo;
        this.Problema = json.Problema;
        this.Publico = json.Publico;
        this.Innovacion = json.Innovacion;
        this.Oculta = json.Oculta;
        this.FechaDeCreacion = json.FechaDeCreacion;
        this.UltimaFechaDeModificacion = json.UltimaFechaDeModificacion;
    }
}
export default Idea;