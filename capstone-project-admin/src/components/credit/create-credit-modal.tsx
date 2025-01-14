"use client";
import { createCreditPackage } from "@/actions/credit-action";
import { creditSchema } from "@/lib/validation/credit-schema";
import { CreateCreditDto } from "@/service/api-types";
import { Button, Input, Modal } from "antd";
import { ErrorMessage, Form, Formik } from "formik";
import { CircleDollarSign } from "lucide-react";
import React, { useState, useTransition } from "react";

function CreateCreditModal() {
  const [isOpened, setIsOpened] = useState(false);

  const [isPending, startTransition] = useTransition();

  const showModal = () => {
    setIsOpened(true);
  };

  const handleCancel = () => {
    setIsOpened(false);
  };

  const handleCreateCredit = async (values: any, resetForm: any) => {
    startTransition(async () => {
      await createCreditPackage({
        ...values,
        points: Number(values.points),
        price: Number(values.price),
        discount: Number(values.discount),
      })
        .then(() => {
          resetForm();
          setIsOpened(false);
        })
        .catch((error) => {
          console.log(error);
        });
    });
  };

  return (
    <>
      <Button className="w-fit" type="primary" onClick={showModal}>
        Create new credit package
      </Button>
      <Modal
        width={700}
        centered={true}
        footer={[]}
        open={isOpened}
        onCancel={handleCancel}
      >
        <Formik
          initialValues={{
            title: "",
            points: "",
            price: "",
            discount: "",
          }}
          validationSchema={creditSchema}
          onSubmit={(values, { resetForm }) =>
            handleCreateCredit(values, resetForm)
          }
        >
          {({ values, handleChange }) => (
            <Form>
              <div className="mb-4 flex gap-x-4">
                <CircleDollarSign size={50} />
                <div>
                  <h1 className="text-xl font-semibold">
                    Create new credit package
                  </h1>
                  <p className="text-sm">Enter package info</p>
                </div>
              </div>
              <div className="w-full grid grid-cols-2 gap-x-8 gap-y-4 mb-4">
                <div>
                  <label
                    htmlFor="title"
                    className="block mb-2 text-sm font-medium "
                  >
                    Title
                    <span className="text-red-500 text-sm ml-1">*</span>
                  </label>
                  <Input
                    name="title"
                    value={values.title}
                    onChange={handleChange}
                    placeholder="Title"
                  />
                  <div className="text-red-500 text-sm mt-2">
                    <ErrorMessage name="title" />
                  </div>
                </div>
                <div>
                  <label
                    htmlFor="points"
                    className="block mb-2 text-sm font-medium "
                  >
                    Point
                    <span className="text-red-500 text-sm ml-1">*</span>
                  </label>
                  <Input
                    name="points"
                    value={values.points}
                    onChange={handleChange}
                    placeholder="Points"
                  />
                  <div className="text-red-500 text-sm mt-2">
                    <ErrorMessage name="points" />
                  </div>
                </div>
                <div>
                  <label
                    htmlFor="price"
                    className="block mb-2 text-sm font-medium "
                  >
                    Price ($){" "}
                    <span className="text-red-500 text-sm ml-1">*</span>
                  </label>
                  <Input
                    name="price"
                    value={values.price}
                    onChange={handleChange}
                    placeholder="Price"
                  />
                  <div className="text-red-500 text-sm mt-2">
                    <ErrorMessage name="price" />
                  </div>
                </div>
                <div>
                  <label
                    htmlFor="discount"
                    className="block mb-2 text-sm font-medium "
                  >
                    Discount (%)
                  </label>
                  <Input
                    name="discount"
                    value={values.discount}
                    onChange={handleChange}
                    placeholder="Discount"
                  />
                  <div className="text-red-500 text-sm mt-2">
                    <ErrorMessage name="discount" />
                  </div>
                </div>
              </div>
              <div className="grid grid-cols-2 gap-x-8">
                <Button
                  className="danger-button"
                  onClick={() => setIsOpened(false)}
                >
                  Cancel
                </Button>
                <Button
                  disabled={false}
                  htmlType="submit"
                  className="primary-button"
                >
                  Submit
                </Button>
              </div>
            </Form>
          )}
        </Formik>
      </Modal>
    </>
  );
}

export default CreateCreditModal;
