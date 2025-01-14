import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { HydratedDocument } from 'mongoose';

export type CreditDocument = HydratedDocument<Credit>;

@Schema({ timestamps: true })
export class Credit {
  @Prop({ required: false })
  title: string;

  @Prop({ type: Number, default: 0 })
  points: number;

  @Prop({ type: Number, default: 0 })
  price: number;

  @Prop({ type: Number, default: 0 })
  discount: number;

  @Prop({ default: true })
  is_visible: boolean;
}

export const CreditSchema = SchemaFactory.createForClass(Credit);
