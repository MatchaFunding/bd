class Persona {
    ID: number;
    Nombre: string;
    Apellido?: string;
    Sexo: string;
    RUT: string;
    FechaDeNacimiento?: string;
    Ocupacion?: string;
    Correo?: string;
    Telefono?: number;
    constructor(json: any) {
        this.ID = json.ID;
        this.Nombre = json.Nombre;
        this.Apellido = json.Apellido;
        this.Sexo = json.Sexo;
        this.RUT = json.RUT;
        this.FechaDeNacimiento = json.FechaDeNacimiento;
        this.Ocupacion = json.Ocupacion;
        this.Correo = json.Correo;
        this.Telefono = json.Telefono;
    }
}
export default Persona;