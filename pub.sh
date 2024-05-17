#!/usr/bin/env bash

case $1 in
  clean)
    echo "cleaning project"
    fvm flutter clean

    cd core
    fvm flutter clean

    cd ../movie
    fvm flutter clean

    cd ../tv
    fvm flutter clean

    cd ../watchlist
    fvm flutter clean
    ;;
  get)
    echo "getting dependencies"
    fvm flutter pub get

    cd core
    fvm flutter pub get

    cd ../movie
    fvm flutter pub get

    cd ../tv
    fvm flutter pub get

    cd ../watchlist
    fvm flutter pub get
    ;;
  upgrade)
    echo "upgrade dependencies"
    fvm flutter pub outdated
    fvm flutter pub upgrade --major-versions

    cd core
    fvm flutter pub outdated
    fvm flutter pub upgrade --major-versions

    cd ../movie
    fvm flutter pub outdated
    fvm flutter pub upgrade --major-versions

    cd ../tv
    fvm flutter pub outdated
    fvm flutter pub upgrade --major-versions

    cd ../watchlist
    fvm flutter pub outdated
    fvm flutter pub upgrade --major-versions
    ;;
esac
