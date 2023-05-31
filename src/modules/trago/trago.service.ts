import { Injectable, Logger } from '@nestjs/common';
import { ITragoService } from './trago.interface';
import { Prisma, trago } from '@prisma/client';
import { PrismaService } from 'src/prisma.service';

@Injectable()
export class TragoService implements ITragoService {
  readonly #logger = new Logger(TragoService.name);

  constructor(private readonly prisma: PrismaService) {}

  async getTragos(where?: Prisma.tragoWhereInput): Promise<trago[]> {
    return await this.prisma.trago.findMany({ where });
  }

  async getTrago(id: Prisma.tragoWhereUniqueInput): Promise<trago> {
    return await this.prisma.trago.findUnique({ where: id });
  }

  async createTrago(data: Prisma.tragoCreateInput): Promise<trago> {
    return await this.prisma.trago.create({ data });
  }
}
