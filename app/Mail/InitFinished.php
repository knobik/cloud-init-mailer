<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;

class InitFinished extends Mailable
{
    use Queueable, SerializesModels;

    private $hostname;
    private $ip;

    /**
     * Create a new message instance.
     *
     * @return void
     */
    public function __construct($hostname, $ip)
    {
        $this->hostname = $hostname;
        $this->ip = $ip;
    }

    /**
     * Build the message.
     *
     * @return $this
     */
    public function build()
    {
        return $this->view('mails.init-finished', [
            'hostname' => $this->hostname,
            'ip' => $this->ip
        ]);
    }
}
