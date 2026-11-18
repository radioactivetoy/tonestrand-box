/*
 * The ToneStrand Box profile: what makes a ToneRelay build a ToneStrand Box (a fork of the Helrig Box profile). It is compiled into ToneRelay's firmware by scripts/build.sh
 * (TONERELAY_PROFILE_DIR points here); see ToneRelay's esp32-p4/components/tonerelay/profiles/README.md for the mechanism.
 *
 * A Wi-Fi network name may contain a space; a host name and a service type cannot, so those read tonestrandbox / _tonestrandbox.
 */
#include "tonerelay.h"

/* setup.html, embedded by the build (EMBED_TXTFILES adds a terminating zero). */
extern const char setup_html_start[] asm("_binary_setup_html_start");
extern const char setup_html_end[] asm("_binary_setup_html_end");

static const char *setup_page(size_t *len)
{
    size_t n = (size_t)(setup_html_end - setup_html_start);
    if (n > 0 && setup_html_start[n - 1] == 0) {
        n--;
    }
    *len = n;
    return setup_html_start;
}

const tonerelay_profile_t TONERELAY_PROFILE = {
    .name = "tonestrand",
    .hostname = "tonestrandbox",       /* tonestrandbox.local */
    .instance = "ToneStrand Box",      /* "ToneStrand Box e7fb0b" once the box id is added */
    .service = "_tonestrandbox",       /* next to the contract's _tonerelay._tcp */
    .ap_prefix = "ToneStrand Box",     /* the setup network, "ToneStrand Box e7fb0b" */
    .with_id = true,
    .setup_ap_only = true,             /* the setup network goes off once the box has joined one */
    .relay_only_default = true,        /* a ToneStrand Box is a relay: the pedal belongs to the app */
    .setup_page = setup_page,
};
