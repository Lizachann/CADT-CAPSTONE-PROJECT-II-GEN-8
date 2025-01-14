"use client"
import { createPost } from "@/actions/post-action";
import { CreatePostDto } from "@/service/api-types";
import { TError } from "@/types/types";
import { convertRcFileToUploadFile, isOkStatusCode } from "@/utils/helper";
import { InboxOutlined } from "@ant-design/icons";
import { Button, Input, Modal, notification, UploadProps } from "antd";
import { RcFile } from "antd/es/upload";
import Dragger from "antd/es/upload/Dragger";
import { ErrorMessage, Form, Formik } from "formik";
import { Sticker } from "lucide-react";
import { useState, useTransition } from "react";

type Props = {}

function CreatePostModal({ }: Props) {
  const initialValues: CreatePostDto = {
    body: '',
    patient: '',
    postPhotos: [],
  }
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [isPending, startTransition] = useTransition()
  const [files, setFiles] = useState<RcFile[]>([])


  const onFinish = async (values: CreatePostDto) => {
    const formData = new FormData()
    if (files) {
      for (let i = 0; i < files.length; i++) {
        formData.append('postPhotos', files[i])
      }
    }

    formData.append('patient', '63686861790123456789abcd')
    formData.append('body', values.body)

    startTransition(async () => {
      await createPost(formData)
        .then((res) => {
          if (!isOkStatusCode(res.statusCode as number)) {
            throw res
          }
          setIsModalOpen(false)
          notification.success({
            message: 'Post created successfully',
          })
        }).catch((e: TError) => {
          notification.error({
            message: `Something went wrong - (${e.statusCode})`,
          })
        })
    })
  };

  const draggerProps: UploadProps = {
    name: 'postPhotos',
    multiple: true,
    accept: "image/png, image/jpeg, image/webp, image/svg+xml, image/jpg",
    fileList: convertRcFileToUploadFile(files),
    onChange(info) {
      const files: any[] = []
      info.fileList.forEach(uploadFile => {
        files.push(uploadFile.originFileObj)
      })
      setFiles(files)
    },
    onDrop(e) {
      console.log('Dropped files', e.dataTransfer.files);
    },
    onRemove(file) {
      setFiles(files.filter(uploadFile => uploadFile.name !== file.name))
    },
  };

  return (
    <>
      <Button type="primary" onClick={() => {
        setIsModalOpen(true);
      }} className="flex flex-col rounded-md items-center justify-center">
        Create Post
      </Button>
      <Modal centered title={(
        <div className="mb-4 flex gap-x-4">
          <Sticker size={50} />
          <div>
            <h1 className="text-xl font-semibold">
              Create a new Post
            </h1>
            <p className="text-sm">Enter post information</p>
          </div>
        </div>
      )} open={isModalOpen} footer={[]}>
        <Formik
          initialValues={initialValues}
          onSubmit={async (values, { setFieldValue }) => {
            await onFinish(values).then(() => {
              setFieldValue('body', '')
              setFieldValue('postPhotos', [])
              setFiles([])
            })
          }}
        >
          {({ handleChange, values }) => {
            return (
              <Form className="w-full flex flex-col gap-4" encType="multipart/form-data" method="POST">

                <div>
                  <label
                    htmlFor="body"
                    className="block mb-2 text-sm font-medium "
                  >
                    Caption
                  </label>
                  <Input value={values.body} name="body" onChange={handleChange} placeholder="Write something here..." />
                  <div className="text-red-500 text-sm mt-2" >
                    <ErrorMessage name="body" />
                  </div>
                </div>

                <Dragger {...draggerProps}>
                  <p className="ant-upload-drag-icon">
                    <InboxOutlined />
                  </p>
                  <p className="ant-upload-text">Click or drag photos to this area to upload</p>
                  <p className="ant-upload-hint">
                    Support for a single or bulk upload. Please upload photos that are aligned with our guidelines.
                  </p>
                </Dragger>
                <div className="text`-red-500 text-sm mt-2" >
                  <ErrorMessage name="postPhotos" />
                </div>
                <div className="grid grid-cols-2 gap-4">
                  <Button
                    onClick={() => {
                      setIsModalOpen(false);
                    }}
                    type="default" className="danger-button" htmlType="submit">
                    Cancel
                  </Button>
                  <Button disabled={isPending} type="primary" htmlType="submit">
                    Submit
                  </Button>
                </div>
              </Form>
            )
          }}
        </Formik>
      </Modal>
    </>
  )
}

export default CreatePostModal
