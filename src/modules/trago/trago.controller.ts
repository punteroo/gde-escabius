import {
  Body,
  Controller,
  Get,
  Param,
  ParseIntPipe,
  Post,
  ValidationPipe,
} from '@nestjs/common';
import { TragoService } from './trago.service';

type CreateTrago = {
  nombre: string;
  precio: number;
  descripcion?: string;
};

@Controller('/trago')
export class TragoController {
  constructor(private readonly tragoService: TragoService) {}

  @Get('/')
  async fetchTragos() {
    return await this.tragoService.getTragos();
  }

  @Get('/:id')
  async fetchTrago(@Param('id', ParseIntPipe) id: number) {
    return await this.tragoService.getTrago({ id_trago: id });
  }

  @Post('/')
  async createTrago(@Body(ValidationPipe) data: CreateTrago) {
    return await this.tragoService.createTrago({
      nombre: data.nombre,
      precio_unitario: data.precio,
      descripcion: data?.descripcion,
    });
  }
}
