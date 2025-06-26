;; Portfolio Manager Verification Contract
;; Simple, working version

;; Constants
(define-constant CONTRACT_OWNER tx-sender)
(define-constant ERR_UNAUTHORIZED (err u100))
(define-constant ERR_ALREADY_REGISTERED (err u101))
(define-constant ERR_NOT_FOUND (err u102))
(define-constant ERR_INVALID_INPUT (err u103))

;; Data Variables
(define-data-var next-manager-id uint u1)

;; Data Maps
(define-map managers
  { manager-id: uint }
  {
    address: principal,
    name: (string-ascii 50),
    title: (string-ascii 100),
    verified: bool,
    registration-block: uint
  }
)

(define-map manager-addresses
  { address: principal }
  { manager-id: uint }
)

;; Public Functions

;; Register a new portfolio manager
(define-public (register-manager (name (string-ascii 50)) (title (string-ascii 100)))
  (let ((manager-id (var-get next-manager-id))
        (caller tx-sender))
    (asserts! (> (len name) u0) ERR_INVALID_INPUT)
    (asserts! (> (len title) u0) ERR_INVALID_INPUT)
    (asserts! (is-none (map-get? manager-addresses { address: caller })) ERR_ALREADY_REGISTERED)

    (map-set managers
      { manager-id: manager-id }
      {
        address: caller,
        name: name,
        title: title,
        verified: false,
        registration-block: block-height
      }
    )

    (map-set manager-addresses
      { address: caller }
      { manager-id: manager-id }
    )

    (var-set next-manager-id (+ manager-id u1))
    (ok manager-id)
  )
)

;; Verify a portfolio manager (only contract owner)
(define-public (verify-manager (manager-id uint))
  (let ((manager-data (unwrap! (map-get? managers { manager-id: manager-id }) ERR_NOT_FOUND)))
    (asserts! (is-eq tx-sender CONTRACT_OWNER) ERR_UNAUTHORIZED)

    (map-set managers
      { manager-id: manager-id }
      (merge manager-data { verified: true })
    )
    (ok true)
  )
)

;; Check if an address is an authorized manager
(define-read-only (is-authorized-manager (address principal))
  (match (map-get? manager-addresses { address: address })
    manager-info
      (match (map-get? managers { manager-id: (get manager-id manager-info) })
        manager-data (get verified manager-data)
        false
      )
    false
  )
)

;; Get manager details
(define-read-only (get-manager-details (manager-id uint))
  (map-get? managers { manager-id: manager-id })
)

;; Get manager ID by address
(define-read-only (get-manager-id (address principal))
  (map-get? manager-addresses { address: address })
)

;; Get total number of managers
(define-read-only (get-total-managers)
  (- (var-get next-manager-id) u1)
)
