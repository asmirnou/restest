#include <memory>
#include <cstdlib>
#include <restbed>
#include "json.hpp"

using namespace std;
using namespace restbed;
using json = nlohmann::json;

void home(const shared_ptr<Session> &session) {
    const auto request = session->get_request();

    size_t content_length = (size_t) request->get_header("Content-Length", 0);

    session->fetch(content_length, [request](const shared_ptr<Session> &_session, const Bytes) {
        json j;
        j["greeting"] = "Hello World!";

        stringstream stream;
        stream << j.dump(4);
        string response_body = stream.str();

        _session->close(OK, response_body, {{"Content-Length", ::to_string(response_body.length())},
                                           {"Content-Type",   "application/json"}});
    });
}

int main(const int, const char **) {
    auto resource = make_shared<Resource>();
    resource->set_path("/");
    resource->set_method_handler("GET", home);

    auto settings = make_shared<Settings>();
    settings->set_port(8080);
    settings->set_default_header("Connection", "close");

    Service service;
    service.publish(resource);
    service.start(settings);

    return EXIT_SUCCESS;
}
