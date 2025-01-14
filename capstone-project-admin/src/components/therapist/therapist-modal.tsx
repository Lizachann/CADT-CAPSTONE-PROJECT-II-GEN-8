"use client";
import useTherapist from "@/lib/hooks/swr-hooks/use-therapist";
import Image from "next/image";
import userProfileIcon from "@/public/images/Doctor_profile_icon.png";
import useSpecialization from "@/lib/hooks/swr-hooks/use-specialization";
import { Button, Input, Modal, Select, SelectProps, Spin, Tag } from "antd";
import { ErrorMessage, Form, Formik } from "formik";
import { Edit2Icon, Trash } from "lucide-react";
import { useEffect, useMemo, useState, useTransition } from "react";
import { therapistSchema } from "@/lib/validation/therapist-schema";
import { updateTherapist } from "@/actions/therapist-action";
import { getRandomColor } from "@/utils/antd-random-color-helper";

type Props = {
  id: string;
};

function TherapistModal({ id }: Props) {
  const [isOpened, setIsOpened] = useState(false);

  useEffect(() => {
    setIsEdit(false);
  }, [isOpened]);

  const [isEdit, setIsEdit] = useState(false);
  const [isPending, startTransition] = useTransition();
  const {
    therapistData,
    isLoading: fetchTherapistLoading,
    mutate: mutateTherapistData,
  } = useTherapist(id);

  const { specializations, isLoading, mutate } = useSpecialization();

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

  const showModal = () => {
    setIsOpened(true);
  };

  const handleCancel = () => {
    setIsOpened(false);
  };

  if (fetchTherapistLoading || isLoading) {
    return <Spin />;
  }

  // Function to get a random color from the colors array

  const handleEditTherapist = (values: any) => {
    startTransition(async () => {
      await updateTherapist(id, values)
        .then(() => {
          mutateTherapistData();
          mutate();
          setIsEdit(false);
        })
        .catch((error) => {
          console.log(error);
        });
    });
  };

  return (
    <>
      <Button type="primary" onClick={showModal}>
        View
      </Button>
      <Modal
        footer={[]}
        open={isOpened}
        onCancel={handleCancel}
        centered={true}
      >
        {isEdit ? (
          <Formik
            initialValues={{
              first_name: therapistData?.first_name,
              last_name: therapistData?.last_name,
              username: therapistData?.username,
              gender: therapistData?.gender,
              email: therapistData?.email,
              bio: therapistData?.bio,
              phone_number: therapistData?.phone_number,
              specializations: therapistData?.specializations,
            }}
            enableReinitialize={true}
            validationSchema={therapistSchema}
            onSubmit={(values) => handleEditTherapist(values)}
          >
            {({ values, handleChange, setFieldValue }) => (
              <Form>
                <div className="mb-4 flex gap-x-4">
                  <Edit2Icon size={50} />
                  <div>
                    <h1 className="text-xl font-semibold">
                      Update Therapist Information
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
                      defaultValue={values?.gender}
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
                <div className="mb-4">
                  <label
                    htmlFor="bio"
                    className="block mb-2 text-sm font-medium "
                  >
                    Bio
                  </label>
                  <Input.TextArea
                    rows={8}
                    name="bio"
                    value={values.bio}
                    onChange={handleChange}
                  />
                </div>
                <div className="grid grid-cols-2 gap-x-8">
                  <Button
                    className="hover:bg-red-500 hover:text-white hover:border-red-500"
                    onClick={() => setIsEdit(false)}
                  >
                    Cancel
                  </Button>
                  <Button disabled={isPending} htmlType="submit" type="primary">
                    Submit
                  </Button>
                </div>
              </Form>
            )}
          </Formik>
        ) : (
          <div className="flex flex-col gap-y-4">
            <h1 className="text-xl font-semibold">Therapist Information</h1>
            <div className="flex w-full justify-between">
              <Image
                src={userProfileIcon}
                alt="Therapist Profile Icon"
                width={150}
              />
              <div className="gap-x-2 flex">
                <Button
                  className="bg-green-600 text-white border-green-600 hover:bg-green-700"
                  onClick={() => setIsEdit(!isEdit)}
                >
                  <Edit2Icon size={20} />
                </Button>
                <Button
                  className="bg-red-500 text-white border-red-500 hover:bg-red-600"
                  onClick={() => setIsEdit(!isEdit)}
                >
                  <Trash size={20} />
                </Button>
              </div>
            </div>
            <div className="flex flex-col gap-y-2">
              <div className="grid grid-cols-2 gap-y-2">
                <div>
                  <label className="font-semibold">First name:</label>
                  <p>{therapistData?.first_name}</p>
                </div>
                <div>
                  <label className="font-semibold">Last name:</label>
                  <p>{therapistData?.last_name}</p>
                </div>
                <div>
                  <label className="font-semibold">Gender:</label>
                  <p>{therapistData?.gender}</p>
                </div>
                <div>
                  <label className="font-semibold">Username:</label>
                  <p>{therapistData?.username}</p>
                </div>
                <div>
                  <label className="font-semibold">Email:</label>
                  <p>{therapistData?.email}</p>
                </div>
                <div>
                  <label className="font-semibold">Phone Number:</label>
                  <p>{therapistData?.phone_number}</p>
                </div>
                <div>
                  <label className="font-semibold">Role:</label>
                  <p>{therapistData?.roles}</p>
                </div>

                <div>
                  <label className="font-medium">Bio:</label>
                  <p>{therapistData?.bio}</p>
                </div>
              </div>
              <div>
                <label className="font-semibold">Specialization: </label>
                {therapistData?.specializations?.map((specialization, key) => (
                  <Tag color={getRandomColor()} key={key}>
                    {specialization}
                  </Tag>
                ))}
              </div>
            </div>
          </div>
        )}
      </Modal>
    </>
  );
}

export default TherapistModal;
