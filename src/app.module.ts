import { Module } from '@nestjs/common';
import { TragoModule } from './modules/trago/trago.module';

@Module({
  imports: [TragoModule],
})
export class AppModule {}
