# github.com/poshjosh/parent
FROM maven:3-alpine
RUN addgroup -S looseboxes && adduser -S poshjosh -G looseboxes
USER looseboxes:poshjosh
