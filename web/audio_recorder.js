class AudioRecorder {
    constructor() {
        this.mediaRecorder = null;
        this.chunks = [];
    }

    async start() {
        const stream = await navigator.mediaDevices.getUserMedia({ audio: true });
        this.mediaRecorder = new MediaRecorder(stream);
        this.mediaRecorder.ondataavailable = (event) => {
            this.chunks.push(event.data);
        };
        this.mediaRecorder.start();
    }

    stop() {
        return new Promise((resolve) => {
            this.mediaRecorder.onstop = () => {
                console.log("eeeeeeeeeeeeeeeeeee")
                const blob = new Blob(this.chunks, { type: 'audio/webm' });
                resolve(blob);
                this.chunks = [];
            };
            this.mediaRecorder.stop();
        });
    }
}

window.AudioRecorder = AudioRecorder;