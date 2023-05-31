import { Module } from '@nestjs/common';
import { TragoService } from './trago.service';
import { TragoController } from './trago.controller';
import { PrismaService } from 'src/prisma.service';

@Module({
  providers: [PrismaService, TragoService],
  controllers: [TragoController],
})
export class TragoModule {}
