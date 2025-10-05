class Usuario {
    ID: number;
    Persona?: number;
    NombreDeUsuario?: string;
    Contrasena: string;
    Correo: string;
    Telefono?: number;
    constructor(json: any) {
        this.ID = json.ID;
        this.Persona = json.Persona;
        this.NombreDeUsuario = json.NombreDeUsuario;
        this.Contrasena = json.Contrasena;
        this.Correo = json.Correo;
        this.Telefono = json.Telefono;
    }
}
export default Usuario;