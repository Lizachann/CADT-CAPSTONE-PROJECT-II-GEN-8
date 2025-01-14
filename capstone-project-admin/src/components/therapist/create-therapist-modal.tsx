"use client";
import { createTherapist } from "@/actions/therapist-action";
import { GENDER } from "@/constants/gender-constant";
import useSpecialization from "@/lib/hooks/swr-hooks/use-specialization";
import { therapistSchema } from "@/lib/validation/therapist-schema";
import { CheckCircleOutlined } from "@ant-design/icons";
import {
  Button,
  Input,
  Modal,
  notification,
  NotificationArgsProps,
  Select,
  SelectProps,
  Spin,
} from "antd";
import { ErrorMessage, Form, Formik } from "formik";
import { Stethoscope } from "lucide-react";
import { useMemo, useState, useTransition } from "react";

function CreateTherapistModal() {
  const [isOpened, setIsOpened] = useState(false);

  const [isPending, startTransition] = useTransition();

  const { specializations, isLoading, mutate } = useSpecialization();

  const [api, contextHolder] = notification.useNotification();

  const showModal = () => {
    setIsOpened(true);
  };

  const handleCancel = () => {
    setIsOpened(false);
  };

  const handleCreateTherapist = async (values: any, resetForm: any) => {
    startTransition(async () => {
      await createTherapist(values)
        .then((res) => {
          successNotification("success", "topRight", res?.message);
          resetForm();
          mutate();
          setIsOpened(false);
        })
        .catch((error) => {
          console.log(error);
        });
    });
  };

  type NotificationPlacement = NotificationArgsProps["placement"];
  type NotificationType = "success" | "info" | "warning" | "error";

  const successNotification = (
    type: NotificationType,
    placement: NotificationPlacement,
    message: string
  ) => {
    api[type]({
      icon: <CheckCircleOutlined className="text-green-500" />,
      message: message,
      placement,
    });
  };

  const specializationOptions = useMemo(() => {
    const options: SelectProps["options"] = [];
    specializations?.forEach((spec) => {
      options.push({
        value: spec,
        label: spec,
      });
    });
    return options;
  }, [specializations]);

  if (isLoading) {
    return <Spin />;
  }

  return (
    <>
      {contextHolder}
      <Button className="w-fit" type="primary" onClick={showModal}>
        Create new therapist
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
            first_name: "",
            last_name: "",
            username: "",
            gender: GENDER.MALE,
            email: "",
            bio: "",
            phone_number: "",
            specializations: [],
          }}
          validationSchema={therapistSchema}
          onSubmit={(values, { resetForm }) =>
            handleCreateTherapist(values, resetForm)
          }
        >
          {({ values, handleChange, setFieldValue }) => (
            <Form>
              <div className="mb-4 flex gap-x-4">
                <Stethoscope size={50} />
                <div>
                  <h1 className="text-xl font-semibold">
                    Create New Therapist
                  </h1>
                  <p className="text-sm">Enter therapist info</p>
                </div>
              </div>
              <div className="w-full grid grid-cols-2 gap-x-8 gap-y-4 mb-4">
                <div>
                  <label
                    htmlFor="first_name"
                    className="block mb-2 text-sm font-medium "
                  >
                    First name
                    <span className="text-red-500 text-sm ml-1">*</span>
                  </label>
                  <Input
                    name="first_name"
                    value={values.first_name}
                    onChange={handleChange}
                    placeholder="Firstname"
                  />
                  <div className="text-red-500 text-sm mt-2">
                    <ErrorMessage name="first_name" />
                  </div>
                </div>
                <div>
                  <label
                    htmlFor="last_name"
                    className="block mb-2 text-sm font-medium "
                  >
                    Last name
                    <span className="text-red-500 text-sm ml-1">*</span>
                  </label>
                  <Input
                    name="last_name"
                    value={values.last_name}
                    onChange={handleChange}
                    placeholder="Lastname"
                  />
                  <div className="text-red-500 text-sm mt-2">
                    <ErrorMessage name="last_name" />
                  </div>
                </div>
                <div>
                  <label
                    htmlFor="username"
                    className="block mb-2 text-sm font-medium "
                  >
                    Username
                    <span className="text-red-500 text-sm ml-1">*</span>
                  </label>
                  <Input
                    name="username"
                    value={values.username}
                    onChange={handleChange}
                    placeholder="Username"
                  />
                  <div className="text-red-500 text-sm mt-2">
                    <ErrorMessage name="username" />
                  </div>
                </div>
                <div>
                  <label
                    htmlFor="gender"
                    className="block mb-2 text-sm font-medium "
                  >
                    Gender
                    <span className="text-red-500 text-sm ml-1">*</span>
                  </label>
                  <Select
                    onChange={(value) => setFieldValue("gender", value)}
                    className="!w-full"
                    defaultValue="male"
                    style={{ width: 120 }}
                    options={[
                      { value: "male", label: "Male" },
                      { value: "female", label: "Female" },
                    ]}
                  />

                  <div className="text-red-500 text-sm mt-2">
                    <ErrorMessage name="gender" />
                  </div>
                </div>
                <div>
                  <label
                    htmlFor="phone_number"
                    className="block mb-2 text-sm font-medium "
                  >
                    Phone number
                    <span className="text-red-500 text-sm ml-1">*</span>
                  </label>
                  <Input
                    name="phone_number"
                    value={values.phone_number}
                    onChange={handleChange}
                    placeholder="+855 12 612 6629"
                  />
                  <div className="text-red-500 text-sm mt-2">
                    <ErrorMessage name="phone_number" />
                  </div>
                </div>
                <div>
                  <label
                    htmlFor="email"
                    className="block mb-2 text-sm font-medium "
                  >
                    Email
                    <span className="text-red-500 text-sm ml-1">*</span>
                  </label>
                  <Input
                    name="email"
                    value={values.email}
                    onChange={handleChange}
                    placeholder="Email"
                  />

                  <div className="text-red-500 text-sm mt-2">
                    <ErrorMessage name="email" />
                  </div>
                </div>
                <div>
                  <label
                    htmlFor="specializations"
                    className="block mb-2 text-sm font-medium "
                  >
                    Specializations
                    <span className="text-red-500 text-sm ml-1">*</span>
                  </label>
                  <Select
                    mode="tags"
                    style={{ width: "100%" }}
                    placeholder="Specializations"
                    value={values.specializations}
                    onChange={(value) =>
                      setFieldValue("specializations", value)
                    }
                    options={specializationOptions}
                  />

                  <div className="text-red-500 text-sm mt-2">
                    <ErrorMessage name="specializations" />
                  </div>
                </div>
              </div>
              <div className="mb-4">
                <label
                  htmlFor="bio"
                  className="block mb-2 text-sm font-medium "
                >
                  Bio
                </label>
                <Input.TextArea
                  name="bio"
                  value={values.bio}
                  onChange={handleChange}
                />
              </div>
              <div className="grid grid-cols-2 gap-x-8">
                <Button
                  className="danger-button"
                  onClick={() => setIsOpened(false)}
                >
                  Cancel
                </Button>
                <Button
                  disabled={isPending}
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

export default CreateTherapistModal;
