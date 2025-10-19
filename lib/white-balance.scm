; GIMP Script-Fu batch white balance module
; Apply auto white balance to images in batch

(define (batch-white-balance input-dir output-dir pattern)
  ; Build the file pattern path - handle both *.jpg and *.JPG
  (let* ((search-pattern (string-append input-dir "/" pattern))
         ; file-glob returns a list directly in GIMP 3.0
         (glob-result (file-glob #:pattern search-pattern #:filename-encoding TRUE))
         (filelist (if (list? glob-result) glob-result (list glob-result))))

    ; Debug: show what we got
    (gimp-message (string-append "Glob result type: " (if (list? glob-result) "list" "other")))
    (gimp-message (string-append "Found "
                                 (number->string (length filelist))
                                 " files matching "
                                 search-pattern))
    ; Show first file if exists
    (if (not (null? filelist))
        (gimp-message (string-append "First item: " (if (string? (car filelist)) (car filelist) "NOT A STRING"))))

    ; Process each file
    (while (not (null? filelist))
      (let* ((filename-raw (car filelist))
             (filename (if (string? filename-raw) filename-raw "ERROR-NOT-STRING"))
             (image (car (gimp-file-load 1 filename)))
             (num-layers (car (gimp-image-get-layers image)))
             (layer (vector-ref (cadr (gimp-image-get-layers image)) 0))
             (basename (car (reverse (strbreakup filename "/"))))
             (output-path (string-append output-dir "/" basename)))

        ; Print progress
        (gimp-message (string-append "Processing: " filename))

        ; Apply white balance (auto levels stretch)
        (gimp-levels-stretch layer)

        ; Flatten image to ensure single layer for export
        (gimp-image-flatten image)
        (set! layer (vector-ref (cadr (gimp-image-get-layers image)) 0))

        ; Save the file
        (gimp-file-save 1 image 1 (vector layer) output-path)

        ; Print saved message
        (gimp-message (string-append "Saved: " output-path))

        ; Clean up
        (gimp-image-delete image)

        ; Move to next file
        (set! filelist (cdr filelist))))

    ; Print completion message
    (gimp-message "Batch processing complete")))
