#include <iostream>
#include <zmq.hpp>

int main() {
    zmq::context_t context;

    zmq::socket_t pull(context, ZMQ_PULL);
    pull.bind("tcp://0.0.0.0:1337");

    for (;;) {
        zmq::message_t message;
        pull.recv(&message);

        std::cout << "Received message: " << message.size() << '\n';
    }

    return 0;
}
