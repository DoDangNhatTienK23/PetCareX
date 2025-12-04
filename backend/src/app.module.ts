import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { AppController } from './app.controller';
import { AppService } from './app.service';

@Module({
  imports: [
      TypeOrmModule.forRoot({
      type: 'mssql',
      host: 'localhost',
      port: 1435,
      username: 'sa',               // Docker uses 'sa'
      password: 'Admin123', // From docker-compose
      database: 'petcarex',
      autoLoadEntities: true,
      synchronize: true,            // Auto-creates tables
      options: {
          encrypt: false,             // Required for local/docker
          trustServerCertificate: true,
      },
  }),
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}

