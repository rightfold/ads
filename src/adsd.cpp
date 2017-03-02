#include <iostream>
#include <zmq.hpp>

int main() {
    zmq::context_t context;

    zmq::socket_t pull(context, ZMQ_PULL);
    pull.bind("tcp://0.0.0.0:1337");

    zmq::message_t channel_message;
    zmq::message_t value_message;
    for (;;) {
        pull.recv(&channel_message);
        if (!channel_message.more()) {
            std::cerr << "expecting more\n";
            continue;
        }

        pull.recv(&value_message);
        if (value_message.more()) {
            std::cerr << "not expecting more\n";
            continue;
        }
        if (value_message.size() != 8) {
            std::cerr << "expecting eight-byte value\n";
            continue;
        }

        std::cout << channel_message.data() << " " << value_message.data() << '\n';
    }

    return 0;
}
