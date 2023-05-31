import { Prisma, trago } from '@prisma/client';

export interface ITragoService {
  /**
   * Trae todos los tragos registrados en el sistema.
   *
   * @param {Prisma.tragoWhereInput} [where] Filtro para la búsqueda de tragos.
   *
   * @return {Promise<trago[]>} Los tragos registrados en la base.
   */
  getTragos(where?: Prisma.tragoWhereInput): Promise<trago[]>;

  /**
   * Trae un trago en específico.
   *
   * @param {Prisma.tragoWhereUniqueInput} id El id del trago a buscar.
   *
   * @return {Promise<trago>} El trago encontrado.
   */
  getTrago(id: Prisma.tragoWhereUniqueInput): Promise<trago>;

  /**
   * Crea un nuevo trago en el sistema.
   *
   * @param {Prisma.tragoCreateInput} data Los datos del trago a crear.
   *
   * @return {Promise<trago>} El trago creado.
   */
  createTrago(data: Prisma.tragoCreateInput): Promise<trago>;
}
