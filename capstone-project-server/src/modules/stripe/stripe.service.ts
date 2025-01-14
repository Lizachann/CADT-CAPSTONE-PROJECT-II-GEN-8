import { Inject, Injectable } from '@nestjs/common';
import { CreateStripeDto } from './dto/create-stripe.dto';
import { UpdateStripeDto } from './dto/update-stripe.dto';
import Stripe from 'stripe';
import { InjectModel } from '@nestjs/mongoose';
import { Patient } from 'src/database/schemas/patient.schema';
import { Model } from 'mongoose';

@Injectable()
export class StripeService {
  private stripe: Stripe;

  constructor(
    @Inject('STRIPE_API_KEY') private readonly apiKey: string,
    @InjectModel(Patient.name) private patientModel: Model<Patient>,
  ) {
    this.stripe = new Stripe(this.apiKey);
  }

  async createPaymentIntent(createStripeDto: CreateStripeDto) {
    const patient = await this.patientModel
      .findOne({
        _id: createStripeDto.patientId,
      })
      .exec();

    const res = await this.stripe.paymentIntents.create({
      currency: createStripeDto.currency,
      amount: createStripeDto.amount,
      metadata: {
        patientId: patient.id,
        patientUsername: patient.username,
        credits: createStripeDto.credits,
      },
    });
    return res;
  }

  async getAllCharges() {
    const res = this.stripe.charges.list();
    return res;
  }

  async getBalance() {
    const res = this.stripe.balance.retrieve();
    return res;
  }

  findOne(id: string) {
    const res = this.stripe.paymentIntents.retrieve(id);
    return res;
  }

  update(id: number, updateStripeDto: UpdateStripeDto) {
    return `This action updates a #${id} stripe`;
  }

  remove(id: number) {
    return `This action removes a #${id} stripe`;
  }
}
