import { BASE_API_URL } from "@/constants/env-constant";
import { io, Socket } from "socket.io-client";

export const socketClient = () => {
  const socket: Socket<ServerToClientEvents, ClientToServerEvents> =
    io(BASE_API_URL);

  socket.on("connect", () => {
    console.log("Connected");
  });

  socket.on("disconnect", () => {
    console.log("Disconnected");
  });

  socket.on("connect_error", (e) => {
    console.log(e);
  });

  return socket;
};
