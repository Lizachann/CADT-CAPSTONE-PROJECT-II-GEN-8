import {
  ExceptionFilter,
  Catch,
  ArgumentsHost,
  HttpException,
  HttpStatus,
} from '@nestjs/common';
import { HttpAdapterHost } from '@nestjs/core';

@Catch()
export class AllExceptionsFilter implements ExceptionFilter {
  constructor(private readonly httpAdapterHost: HttpAdapterHost) {}

  catch(exception: Error, host: ArgumentsHost): void {
    const { httpAdapter } = this.httpAdapterHost;

    const ctx = host.switchToHttp();
    const request = ctx.getRequest();
    const requestQuery = request.query;

    const httpStatus =
      exception instanceof HttpException
        ? exception.getStatus()
        : HttpStatus.INTERNAL_SERVER_ERROR;

    const responseBody = {
      statusCode: httpStatus,
      timestamp: new Date().toISOString(),
      path: httpAdapter.getRequestUrl(ctx.getRequest()),
      messages: [exception.message ?? String(exception)],
      errorType: exception.name,
      validationMessages: Array.isArray(exception['response']?.message)
        ? exception['response']['message']
        : Boolean(String(exception))
          ? [exception.message ?? String(exception)]
          : [],
    };

    httpAdapter.reply(
      ctx.getResponse(),
      requestQuery.page <= 0 ? { ...responseBody, data: [] } : responseBody,
      httpStatus,
    );
  }
}
