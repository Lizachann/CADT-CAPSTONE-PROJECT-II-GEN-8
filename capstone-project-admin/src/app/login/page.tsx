import { logo } from "@/utils/image-req-helper";
import { Spin } from "antd";
import BaseImage from "@/components/ui/base-image";
import { Suspense } from "react";
import LoginForm from "@/components/login/login-form";
import { Metadata } from "next";
import { pageMetadata } from "@/utils/metadata-helpter";

type Props = {};

export const metadata: Metadata = pageMetadata({
  title: "Login",
});

export default async function LoginPage({ }: Props) {

  return (
    <section className="bg-gray-50 dark:bg-gray-900">
      <div className="flex flex-col items-center justify-center px-6 py-8 mx-auto md:h-screen lg:py-0">
        <div className="flex items-center mb-6 text-2xl font-semibold text-gray-900 dark:text-white">
          <BaseImage className="w-8 h-8 mr-2" src={logo} width={64} height={64} alt="logo" />
          Chhantek
        </div>
        <div className="w-full bg-white rounded-lg shadow dark:border md:mt-0 sm:max-w-md xl:p-0 dark:bg-gray-800 dark:border-gray-700">
          <div className="p-6 space-y-4 md:space-y-6 sm:p-8">
            <h1 className="text-xl font-bold leading-tight tracking-tight text-gray-900 md:text-2xl dark:text-white">
              Sign in to your account
            </h1>
            <Suspense fallback={<Spin />}>
              <LoginForm />
            </Suspense>
          </div>
        </div>
      </div>
    </section>
  );
}
