class Proyecto {
    ID: number;
    Beneficiario: number;
    Titulo: string;
    Descripcion: string;
    DuracionEnMesesMinimo: number;
    DuracionEnMesesMaximo: number;
    Alcance: string;
    Area: string;
    Problema?: string;
    Publico?: string;
    Innovacion?: string;
    Proposito?: string;
    ObjetivoGeneral?: string;
    ObjetivoEspecifico?: string;
    ResultadoEsperado?: string;
    constructor(json: any) {
        this.ID = json.ID;
        this.Beneficiario = json.Beneficiario;
        this.Titulo = json.Titulo;
        this.Descripcion = json.Descripcion;
        this.DuracionEnMesesMinimo = json.DuracionEnMesesMinimo;
        this.DuracionEnMesesMaximo = json.DuracionEnMesesMaximo;
        this.Alcance = json.Alcance;
        this.Area = json.Area;
        this.Problema = json.Problema;
        this.Publico = json.Publico;
        this.Innovacion = json.Innovacion;
        this.Proposito = json.Proposito;
        this.ObjetivoGeneral = json.ObjetivoGeneral;
        this.ObjetivoEspecifico = json.ObjetivoEspecifico;
        this.ResultadoEsperado = json.ResultadoEsperado;
        this.Historico = json.Historico;
    }
}
export default Proyecto;